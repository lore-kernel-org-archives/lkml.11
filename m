Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C231C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 02:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiBPCKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:10:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiBPCKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:10:05 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30D1FBA52
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:09:54 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id x6-20020a4a4106000000b003193022319cso889503ooa.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xYF0pO2IgFFXUS+S+srQLj8t9yqUYK8NKQTShN2w85A=;
        b=DBgR2HKCuDDuDibXockHuf+4mT2HMWTFfCQfgcpfnrt9+u9CPW/q6iRnqsEl9qY5mX
         jkn7P7IA4hC1uY8sjpebe4rpNJ3M0cBEhEpAwgtjrvMZw0W1FX156l1YwuvRh4IzGuHs
         iWCyDTEfU7pB7ABUmGc1+EF9B55dqojGiJ4pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xYF0pO2IgFFXUS+S+srQLj8t9yqUYK8NKQTShN2w85A=;
        b=5u8dM/gCKZUUN3eKc2OnnuIqolKt9CxjYay8d6pQFxPUfvRuxXrWO752khAs28PKHS
         SXdKt5D5JURVaQBdeGanzsJfVgGhBRPVBq/Vi28IrwxraeAe10p5Q8RMskeeyoXTMnOd
         0bPEz/aU0a4g3mwE2wSlQT5G0AnMR9oT08yBWSGBNZBSxFVX5B6a6HV1U/RCM8jxJV6o
         OYt3GTNKBBPrcdMpqdv+OTbrLo5Gk7m0gzRLJh6P0X8tUmW7DsVrSf85MwFckGbeBaHS
         8IhMAUZn5ujt9hDQDjPDxRMa3cDE8W7LhtulLX2Ob7IhyHe3AoMTE6iWj89olbX28b7e
         mC9w==
X-Gm-Message-State: AOAM5316ORpqpgaJ87vtRe9q2gdFUp40PaI4rI9V/lzNhB2KVW3Mj7Yn
        /mfNVCDQEGX3HLezMpc82I8Yr/Q1FMZu/WtMZZg67Q==
X-Google-Smtp-Source: ABdhPJw/KDAgE0FdHBRrKIXoSn234wcOgh4yzCcAHECcfKZ1d1mwF/UbuwfaqjuDp9dlk+kLltLS8k0JkJ3SxZ6KhIs=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr277376oao.8.1644977392226; Tue, 15 Feb
 2022 18:09:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Feb 2022 18:09:51 -0800
MIME-Version: 1.0
In-Reply-To: <CAOOzhkpDvR14-D9YcZzbAQdQkDmas_XUtV-CLBR7+a3AuxgstQ@mail.gmail.com>
References: <20220211012510.1198155-1-swboyd@chromium.org> <20220211012510.1198155-2-swboyd@chromium.org>
 <CAOOzhkpDvR14-D9YcZzbAQdQkDmas_XUtV-CLBR7+a3AuxgstQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Feb 2022 18:09:51 -0800
Message-ID: <CAE-0n52aueW5N+d2d6tjWtca31werhwk6-6yqDm-XibtTfJsTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Input: Extract ChromeOS vivaldi physmap show function
To:     "Sean O'Brien" <seobrien@chromium.org>
Cc:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean O'Brien (2022-02-15 13:50:03)
> Hi Stephen,
>
> Thanks for updating the vivaldi functionality with these patches.=C2=A0 I=
 took
> a look at your changes and I don't have any objections.=C2=A0 I also test=
ed
> on a couple of HID vivaldi keyboards and they worked as expected.

Thanks. Can you provide a Tested-by: tag with your name and email?
