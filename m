Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C94ECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 23:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiH2Xut (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiH2Xu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:50:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB4A6C74
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:48:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m2so9538414lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tXh5f4oHlqPVW2JLbhTBk/vYxYo+WUJFqzPTClFw+iM=;
        b=jsLvwr2qAQUYE3XFVDmlRsETk1iLfCpbWotNhN9qacBxkuPHqb16EXaD+09inJFtCJ
         1DsZN3shM56yCfbuJ/722MphMOXJxlmXNbdqj7HXOASvZw8V2SqpJiatflvjOj5Qkc0L
         Nqm3MV3Jv8Y6rW8v1ARUG1xDIMow96irvTLpFV9U4Z22clw1AyEF4+bdxRMePFY0bXtM
         Ip6FPrrbKf74rfYLVrsyCCYaDM9AeL87w+Nirjq6HZ8IYK7ndETIArz7HqceNshsBam8
         +MkgejxozKeHG3bjCkwAuX+7GUu65A2qWW2eUYW6QcAF7RFCrUhBoHrVbz2remzob8zx
         m7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tXh5f4oHlqPVW2JLbhTBk/vYxYo+WUJFqzPTClFw+iM=;
        b=IGmJaRYmvWE+m1GuYisBudpZaOCfCy1XUB0lwsyjq0l55orVAQbauJRdC6f4p0422m
         GRsuCC3Ak77yVrU2zanp635KQlXtluW7gjRf2WA6P0fB420S4XqkpU8uwENonNvNB38x
         znY63Vo2+Qfb9WpXWHkCrpPzCavGk8jcIv3i5pPc9H1XOCoYtA9jGmkYAlc/ifppU0hb
         pA1XhWA0QFwpiMNtg0DDcTQJMUokM2Mlz8GWbM1ssIRos2k8myT1s1ldpiAzh9E14G9Q
         T/QIA54CgpRGNQj0h5/THkciDe0MZZygcLa5cBbHImp8AnOxoVg+m5IdoFaxTZ/vGcm1
         QRfQ==
X-Gm-Message-State: ACgBeo1LA64yyWturEAZYFgDLWUFHvBNEx1zQfIJ95Gj5kyX6ZPHDK+0
        L2LxAC/UMTTo69bm0HVcPzdT6Z0oDxRiCKRJTd7E
X-Google-Smtp-Source: AA6agR4PTLC6UI6xwc/o+XPWz6+E478fKEeURiUz/O52s2EkX7Ar1iJMJ/t3BspKNPngYLEUbM0b/mMATI7KDdSgLd4=
X-Received: by 2002:a05:6512:3c9b:b0:48b:40ea:c9f2 with SMTP id
 h27-20020a0565123c9b00b0048b40eac9f2mr6746704lfv.170.1661816900359; Mon, 29
 Aug 2022 16:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220829162609.25105-1-wuchi.zero@gmail.com>
In-Reply-To: <20220829162609.25105-1-wuchi.zero@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Aug 2022 19:48:09 -0400
Message-ID: <CAHC9VhQ9gPdXCJ-hjHu9c7NmkSnLGe-=w=6w2ZyGcUfJ+gxvbA@mail.gmail.com>
Subject: Re: [PATCH] audit: use time_after to compare time
To:     wuchi <wuchi.zero@gmail.com>
Cc:     eparis@redhat.com, rgb@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:26 PM wuchi <wuchi.zero@gmail.com> wrote:
>
> Using time_{*} macro to compare time is better
>
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  kernel/audit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Merged into audit/next, thanks!

-- 
paul-moore.com
