Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 11:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiBWLpz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiBWLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:45:51 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557B996BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:45:22 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:45:10 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Error when compiling kernel module - Re: More power management
 updates for v5.17-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     eh kernel <ehkernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Message-Id: <AZ9R7R.OM8VC34SU42J2@crapouillou.net>
In-Reply-To: <CAJZ5v0gb4Dra_NTQjcP8T7Cqy6ejRUV3MgcKC0RPSL_0kqTsuA@mail.gmail.com>
References: <CAGsy+6s36Vf+n9cMbis2a=A4=dUNvsbda7K7rszHikq_HGOAtA@mail.gmail.com>
        <CAJZ5v0iNLXVAR8fG-gjnRP4BSwReL1sZ9XiLHvO+YVKFJFjGOQ@mail.gmail.com>
        <VSXN7R.644PDRMKJL992@crapouillou.net>
        <CAJZ5v0gb4Dra_NTQjcP8T7Cqy6ejRUV3MgcKC0RPSL_0kqTsuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Le lun., févr. 21 2022 at 17:44:28 +0100, Rafael J. Wysocki 
<rafael@kernel.org> a écrit :
> On Mon, Feb 21, 2022 at 5:29 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  Hi Rafael,
>> 
>>  Le lun., févr. 21 2022 at 17:18:51 +0100, Rafael J. Wysocki
>>  <rafael@kernel.org> a écrit :
>>  > On Mon, Feb 21, 2022 at 1:15 PM eh kernel <ehkernel@gmail.com> 
>> wrote:
>>  >>
>>  >>  Hi Rafael,
>>  >>
>>  >>  I now get an error when compiling the kernel module 
>> (out-of-tree)
>>  >> with the new PM macros.
>>  >>
>>  >>  /home/ubuntu/pressure/bmp280-core.c:1163:28: error: expected
>>  >> ‘)’ before ‘(’ token
>>  >>   1163 |      bmp280_runtime_resume, NULL);
>>  >
>>  > Which of the macros has triggered this error?
>> 
>>  I think the bug was introduced by 23a133c1ba67 ("iio:adc:ab8500: 
>> Switch
>>  from CONFIG_PM guards to pm_ptr() etc")
>> 
>>  The macro takes 4 arguments and its first parameter should be the
>>  dev_pm_ops name, so "ab8500_gpadc_pm_ops".
>> 
>>  It slipped during review.
> 
> I see.
> 
> Can you fix this, please?

Jonathan already fixed it in his tree.

Cheers,
-Paul


