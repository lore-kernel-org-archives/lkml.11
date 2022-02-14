Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 14:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbiBNOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:01:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354812AbiBNOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:01:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA974A3CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:01:47 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y5so29379957pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtJBXFGxhLB/AmPMwrX/NjwznKIH/7fgrpcoz8N5kic=;
        b=opjh4f8gNr9LBqCC2YFoI7Ml6wBw/eNpZpnkURCXwARbUFRl0LbAitddUQUeVvcd9q
         2cQ7AjupuKzoZne+LFlxFgc0crV/hgsy7GSVhS3ar7stu8L5jM5PmeKcl/4bc5gclrEH
         BQIT2sMNOGUWLgsYFsX/4yFayo5EbRH+Oo9rbSKxphD9lFvICU64PklAcHsvUGc9QIdx
         pFgrln57ki4yUj7YE7iqpzj93+1Io0dVbuBU5Nn8opmrp55gPpVxDAOtxInegprQjBgT
         03LOSr5GnDgKG1DGgdMxhVJLKmQvuJYt3RGPNjFlb1lcqOEUdLx1ZKsclib+F2R7FjB8
         uECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtJBXFGxhLB/AmPMwrX/NjwznKIH/7fgrpcoz8N5kic=;
        b=TWQa0Z8iJlZSQ+iKwrnFoOgoqOdfgK5a3KAIs+/co81WoTEZG/HMWcS8FpZsZ1g8Uq
         W+pUVaP7QeDqJy3qdjNkqyhKejuB4dvUvqtcGTKfz7AAXUkNVqvCwlsaYb0QWO8yPhVI
         Z3YivvIjjgVTTGpZO9hDAnXKo3xmfWA/zibJhfZVLs9k1ilVcm0wikMaW3w+Aet6U1tn
         D0sZ/G3aQ3eO65A99a1x6uo2pzewN/5RyWDRrPhfDGo0VxKgze5WA/XIThOKo9BLOSNX
         0/1eJ37HK6iIKtOxjLDBb+uNfeaF4RMaxzneWx0ND7lxrJ6ZT6kBhOyjWsMM1G+Ii7s6
         KRbQ==
X-Gm-Message-State: AOAM532aHD8VKnLN7ZDm2NPfz1NvLBukw9EuygFnIpj4Jzo6B1FLISoT
        QjG7FxOQY3fUQOSlJd6B6264hZj6Kn02MNEth0RcYw==
X-Google-Smtp-Source: ABdhPJzffjo+QEwNzDHB0CRx9MnWlZITjtNpnpzUbwKFvAptOlvtj8ik632DCVeAC05OtDlqOFH6LOL4qpS6dV3iuf8=
X-Received: by 2002:a63:d848:: with SMTP id k8mr11972681pgj.164.1644847306786;
 Mon, 14 Feb 2022 06:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20220214124701.105814-1-yang.lee@linux.alibaba.com> <307ca790-e9ca-c8f3-e0f7-28ad594db2aa@linux.intel.com>
In-Reply-To: <307ca790-e9ca-c8f3-e0f7-28ad594db2aa@linux.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 14 Feb 2022 15:01:35 +0100
Message-ID: <CAOtMz3P0-y0NX8BM2SpEf3ZnaWO0nRfchRSv-nAJm51JJOn+Cw@mail.gmail.com>
Subject: Re: [PATCH -next v2 RESEND] i2c: designware: remove unneeded semicolon
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 lut 2022 o 14:03 Jarkko Nikula
<jarkko.nikula@linux.intel.com> napisa=C5=82(a):
>
> Hi
>
> On 2/14/22 14:47, Yang Li wrote:
> > Eliminate the following coccicheck warnings:
> > ./drivers/i2c/busses/i2c-designware-amdpsp.c:172:2-3: Unneeded semicolo=
n
> > ./drivers/i2c/busses/i2c-designware-amdpsp.c:245:2-3: Unneeded semicolo=
n
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > ---
> >
> > --Changes in v2:
> >    According to Jan's suggestion
> >    Fix the same problem in check_i2c_req_sts() function.
> >
> >   drivers/i2c/busses/i2c-designware-amdpsp.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> For future contributions: Technically this would be v3 rather than v2
> RESEND since you fixed the typo in commit log noted by Jan for v2.
>
> Please use RESEND only if you'll send exactly the same version for
> instance if you didn't receive any comments for several weeks or some
> recipient was missing from Cc field.
>
> I believe Jan will give Reviewed-by tag to this version too.
>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Correct.
Reviewed-by: Jan Dabros <jsd@semihalf.com>

Best Regards,
Jan
