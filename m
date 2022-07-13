Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D773AC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiGMSSt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGMSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:18:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C319C1B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:18:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so15265233ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLaLblQd1msZWwY9FiReYrNm7ZLhdWFbMkP58jqCGA8=;
        b=LBXWbxHrwlSAa2xQU0mbSSLoCYx7g55A+eR9KWl97wN1VeT8uphM+HgXqYIYO4Aur2
         EdpfiOasKKdceP2dm3EIrp02LI0czYATVPeoJbqXxXkllYv9Qt/SAT5N+e6pT2B3OzZ1
         XnSFN6xmmOdT972YMzrJ8VNw/5Fzx0hEfCHiXpWdHERP1l/4Ij6ns0YligN0JsPWL+fe
         yXB2sw3wm7JPANQlMqIDXfs+ubX1zmNFVX2QEqPsHIwyxHTSXlVoQXkll/nTqnYti14k
         cSm/Z/olJTDzjY9pDEJZOSOik/E3of86mI0HkkUUv3r68LguOz+NysGB4IRQUyclLF2x
         W8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLaLblQd1msZWwY9FiReYrNm7ZLhdWFbMkP58jqCGA8=;
        b=d0F6bGrSftz2ocTkBWhIuaOllycfi7mgb57ulOuI0BIDer/a8grqJqCN5L8YgzDz+A
         XikmjpqsP9ltQO34SzSEoo84TVj0OYuFKlk397QYzOYMffSYcpYXTf4AhIkhfarUxnP3
         9TqfBv6uS8E9oVS4UHaTXV3XtJJkEY0yn4X11S8iBi5WYeIzOc0iwbOOSjTWuzXQ9xXb
         QxsWLAI7dKt72SyBUXabE/VBSrSQ5l35ToXhcUTJwAGjcaRSX3YQYD7sWBr8ZwRr5wH8
         vgaSmihnuND3iZRsinbGEorXXxbsoXWot+DI7/PiVVsF3G8wZiKr2SGno6kI3NYEKkZt
         ceag==
X-Gm-Message-State: AJIora+/2XxkgXy0dihw6Z9pwu+0Rl8fZxPoiy9hIR1Gl6wwolXVG5cd
        H/PjWz4JNNp7tTfMbjxm2gEdgF4+m4w38TLNw/5mbA==
X-Google-Smtp-Source: AGRyM1teizRCFtWFKbPHLS6yIUMTOL2oH8WTlV4P3Mml7SNEMBR21p9JLUZzeig/m9tzX0V1nujmXSJmHdnx6euZw80=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr4793767ejc.344.1657736324173; Wed, 13
 Jul 2022 11:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-8-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-8-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:18:32 -0700
Message-ID: <CABXOdTft0Nu_hJQuXwepBXE3tWZf7jaidGE5mamq_=1Zi4hevg@mail.gmail.com>
Subject: Re: [RESEND PATCH 07/11] platform/chrome: cros_ec_proto: return
 -EAGAIN when retries timed out
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
> EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
> cros_ec_wait_until_complete() doesn't return an error code.
>
> Return -EAGAIN in the case instead.

Does this make sense, or should it be -ETIMEDOUT ? What does the EC do
if it is still busy (stuck ?) with executing a command and it gets
another one ?

>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 466ecb063bd6..49772a4c5353 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -167,6 +167,9 @@ static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *
>                         break;
>         }
>
> +       if (i >= EC_COMMAND_RETRIES)
> +               ret = -EAGAIN;
> +
>         kfree(msg);
>         return ret;
>  }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
