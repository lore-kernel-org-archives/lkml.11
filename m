Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04238C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbiESRHV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiESRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:07:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066D9BAEF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:07:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so10293070lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBzTfN538cxBF+q89A7MrTkcGPI553HZ7cX5UmHJfys=;
        b=B0Mu/43QbEIOlNIrY4EF6Nu9VKILrU5jInF7PJeWChpZlGVenW1CcucpwyTj5xpz2Z
         9BJ8VarPMzBRSmVfD8oVbg/DS4cvoIHaMVke/ZWI+u8FNxumHWBcEMh/ifz4r4ArBK79
         Izlrm8gSFCMY8EWlqttn/m0VKTJSwQxlLFdSGF5hbCXUMDxPgMsCNPhE822mEGsihzm8
         hDh9a6GVpgmwYpOxpjwsuP1EDOlU/7NgPHLphuwnYICM27RfSisYO58bc6btroxc3Huo
         GuEdhFK/AkvX68eTJmt8Xa30n5AOBcNCA7Gbk2rXpO9NAyaZVuae9c8d3wt3brM04Xkv
         aKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBzTfN538cxBF+q89A7MrTkcGPI553HZ7cX5UmHJfys=;
        b=2iGlYICTvorgDZ/hnVT/kUI07yTqSlzgfTQI5urEXxBitEAvj2O/nO6t8hJ4XniIAi
         jgQ69UUbnjW8oMSe/W5m8rLMi3K5yyl2nCnJzgueH+wbSHPRTvfRKOvvcvoRhEgc61Zk
         gbTltr6JRnfZhdnTMFHfynKy7Av5JhAoX+B0ZHdngRcJFFxuPa/ZyeFonLPc3nfx4qyB
         MfrYYrwou0PzWuY8T+/kbZTVYqGTswaxp6/xQEAGOtWobf+3X+fp2Z1duYtXphb4Q9jX
         lLNB038g4GzRjXhyTN6kdJuqqypPe2q7Q11YH+q5afrJUB4UJRaH6oaGSNG35ZDQkrke
         zFcQ==
X-Gm-Message-State: AOAM5327qkHugyEBnZdil55WO9y5YXoYLIUsZS0i4yw4TFBsqlnkXMe9
        LPqKLpQzRkjbl40UU9XJP7gjtpr98O0USbAU7zu1gQ==
X-Google-Smtp-Source: ABdhPJxxxdKP9TrSrJ1YhuI+eB9YOKpKXMYmaWR0EnKvCcI2zCLJBZAr1P2MAvT+1/RWMg3ZJu8s6kfpkgU7FL7qp3k=
X-Received: by 2002:a05:6512:23a6:b0:477:943a:818d with SMTP id
 c38-20020a05651223a600b00477943a818dmr3942903lfv.644.1652980035171; Thu, 19
 May 2022 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220518153126.265074-1-john.allen@amd.com>
In-Reply-To: <20220518153126.265074-1-john.allen@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 19 May 2022 10:07:03 -0700
Message-ID: <CAMkAt6p7YCZye7C974TLBzrXE3Wt=m6bFGOrV=p8g8w7P3fnbw@mail.gmail.com>
Subject: Re: [PATCH v4] crypto: ccp - Use kzalloc for sev ioctl interfaces to
 prevent kernel memory leak
To:     John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Nguyen <theflow@google.com>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 8:31 AM John Allen <john.allen@amd.com> wrote:
>
> For some sev ioctl interfaces, input may be passed that is less than or
> equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data that PSP
> firmware returns. In this case, kmalloc will allocate memory that is the
> size of the input rather than the size of the data. Since PSP firmware
> doesn't fully overwrite the buffer, the sev ioctl interfaces with the
> issue may return uninitialized slab memory.
>
> Currently, all of the ioctl interfaces in the ccp driver are safe, but
> to prevent future problems, change all ioctl interfaces that allocate
> memory with kmalloc to use kzalloc and memset the data buffer to zero
> in sev_ioctl_do_platform_status.
>
> Fixes: 38103671aad3 ("crypto: ccp: Use the stack and common buffer for status commands")
> Fixes: e799035609e15 ("crypto: ccp: Implement SEV_PEK_CSR ioctl command")
> Fixes: 76a2b524a4b1d ("crypto: ccp: Implement SEV_PDH_CERT_EXPORT ioctl command")
> Fixes: d6112ea0cb344 ("crypto: ccp - introduce SEV_GET_ID2 command")
> Cc: stable@vger.kernel.org
> Reported-by: Andy Nguyen <theflow@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: John Allen <john.allen@amd.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
