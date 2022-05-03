Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B88C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiECRBK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiECRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:01:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DD1B782
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:57:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so24174971wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYcnfPdP2YFPqxvw0fsggQcZVAnAQmS6dFaTxJq5i8k=;
        b=FMFy3jvLMavlPWUDXpgPBVGEmDKBOmqrk2zow+GU495ct9Ki1pF9MCmUXxg3XIuijJ
         7UiXMDiSSxsYnSFlD0pXCbw/OH7UqpqB6cebpnJNCWnudjTCtvBIpQlnGiZ6Pyu4F5r9
         YEH8lH6u8/ePw6ZY5VcjSBTYcxE0AUMNwfQZc2iTTVOEIWfsOSiTX6NEojVMTzDnB1qu
         Wkqpd5DKL6DbHPp3/m6+ugvYwV8swiUNdMvR/Cyr6YupYp1LEPz3SdtdbTHZztpalu4Z
         wzVV1X2ReIgYudhSwoi1V3so3GGZqHQ3oefuPpPzakVEdYTfamXhjCfksttVWa2DF1co
         +/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYcnfPdP2YFPqxvw0fsggQcZVAnAQmS6dFaTxJq5i8k=;
        b=K0W81JqWh/+8m7JS83rQkhLv3VWa/ESLBya8D26xnw0j4i+Yy3Bc0XWFDdmucTDDx+
         c1q9lx2RzJpoudp4B48ufRYODq/0gd+h0t5tWfbnIo1sDm11kwqrha9WAbDlcCj9XwRx
         QhGOaBfxmgL60bm+qJ1ahsWGZqNv4zsd6Gu8wKBvpwZqWUAnj1JJKJhkgdHo7DYJnn2+
         q8gITsu9et7hGeds/NK0xqdKBHZEQVwA7o1h7XZyJAUOP84MfoojGmRjvJKB5lZgWzlR
         EoaYxYqzRCEsX5C+PdkYWLF/HIaRPMEMoJxM2wVYci4CYC8mF69wuGAogiy7X4Q6r1um
         w9jQ==
X-Gm-Message-State: AOAM531clv0iA0aBnTnVDH/Acz+ZAzJ4CTwl8hGNM/oPthRR5+YeBQar
        Vr9QOJaaL1n3fqj5F1b5vWTcc//Wd5uD4ffCc9nz
X-Google-Smtp-Source: ABdhPJxUN2yPflP0Pq5iqeCasV+xXLJxQdUAMk0TgokW1vgrA793O558pwIKvJF1n8yAtA8kYwZyJ5/LKMf4x7DOZww=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr13043310wrq.395.1651597052331; Tue, 03
 May 2022 09:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220503090212.1322050-1-svens@linux.ibm.com> <20220503090212.1322050-2-svens@linux.ibm.com>
In-Reply-To: <20220503090212.1322050-2-svens@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 12:57:21 -0400
Message-ID: <CAHC9VhQ44G1oXLHTf7FmqwzYBRNW=5EPHod1uMTLhaY3sK_Qeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: add filterkey to special audit messages
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 5:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> For automated filtering/testing it is useful to have the
> filter key logged in the message.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/auditsc.c | 1 +
>  1 file changed, 1 insertion(+)

The SOCKETCALL record, along with all of the others generated inside
show_special(), are associated with a SYSCALL record which carries the
"key=" field.  As a general rule we try very hard not to duplicate
fields across records in a single audit event.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index c856893041c9..2e349660a56f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1508,6 +1508,7 @@ static void show_special(struct audit_context *context, int *call_panic)
>                 audit_log_time(context, &ab);
>                 break;
>         }
> +       audit_log_key(ab, context->filterkey);
>         audit_log_end(ab);
>  }
>
> --
> 2.32.0

-- 
paul-moore.com
