Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A42C19F2A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiHGP6Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHGP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:58:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF064F7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659887900; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQiLAvgzEEfP3rMxIC8AKUTNIorsHnyk/WzhGT3MRpo=;
        b=ztXiNTMBdlys5aUEUINc9rdw+mnZrG1gJA0BJR0eAvf5hqeTshalUFF3HqSWxJpu0xtLPG
        RLiJuGBx5Aie98VHQCi3o/DhBUaQj00YPGvdV7Y5HAT2qLX18dfJVywJTnkvviRLEHqLWJ
        UUVCOo6DV3s2yFO0UCWuc+WSDKdx0es=
Date:   Sun, 07 Aug 2022 17:58:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 11/28] mfd: intel_soc_pmic: Remove #ifdef guards for PM
 related functions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Message-Id: <RO59GR.D1GGMPYPNKQG2@crapouillou.net>
In-Reply-To: <CAHp75Vf1jfgshfw1ymXu9AHrNy1SUmVRDvDLUYbYKFSrhQq44A@mail.gmail.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
        <20220807145247.46107-12-paul@crapouillou.net>
        <CAHp75Vf1jfgshfw1ymXu9AHrNy1SUmVRDvDLUYbYKFSrhQq44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim., ao=FBt 7 2022 at 17:50:32 +0200, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Sun, Aug 7, 2022 at 4:53 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
>>  to handle the .suspend/.resume callbacks.
>>=20
>>  These macros allow the suspend and resume functions to be=20
>> automatically
>>  dropped by the compiler when CONFIG_SUSPEND is disabled, without=20
>> having
>>  to use #ifdef guards.
>>=20
>>  The advantage is then that these functions are now always compiled
>=20
> is that

I think that what I wrote is proper English.

>=20
>>  independently of any Kconfig option, and thanks to that bugs and
>>  regressions are easier to catch.
>=20
> ...
>=20
>>   drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
>>   drivers/mfd/intel_soc_pmic_core.c  | 8 +++-----
>=20
> 1. These are two different drivers, the patch needs to be split.

Ok.

> 2. The Broxton Whiskey Cove should have a similar change. Which base
> have you used for your patch? Please, rebase on top of for-mfd-next.

That's based on v5.19.

> 3. The PMIC core actually is Crystal Cove driver and I have a pending
> series for that and I guess you know about it. Have you seen what have
> been done there?

No, I didn't know. I guess Lee can skip my patch 11/28 then.

Cheers,
-Paul


