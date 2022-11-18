package personal_project.look_style.controller.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import personal_project.look_style.service.member.request.MemberSignInRequest;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MemberSignInForm {

    private String email;
    private String password;

    public MemberSignInRequest toSignInRequest () {
        return new MemberSignInRequest(email, password);
    }
}
