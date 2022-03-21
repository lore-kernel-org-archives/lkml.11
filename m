Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2886C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 14:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbiCUOfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbiCUOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:33:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BE5E77F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:30:06 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nWJ2p-00029J-Ve; Mon, 21 Mar 2022 15:30:04 +0100
Message-ID: <41eaaf17-1456-5971-e7d9-e5ccc65bcf01@leemhuis.info>
Date:   Mon, 21 Mar 2022 15:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
Content-Language: en-US
To:     =?UTF-8?Q?=c3=89ric_Valette?= <eric.valette@free.fr>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Dominique Dumont <dod@debian.org>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        1005005@bugs.debian.org, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan>
 <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
 <5164225.DI6hChFYCN@ylum> <c62d4ba9-2214-ca7d-ee78-ee19a9bf51e6@free.fr>
 <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com>
 <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
 <ba7faa48-68a5-41f9-9192-f843e17c5a07@free.fr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ba7faa48-68a5-41f9-9192-f843e17c5a07@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1647873006;988f5919;
X-HE-SMSGID: 1nWJ2p-00029J-Ve
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 13:07, Éric Valette wrote:
> My problem has never been fixed.
>
> The proposed patch has been applied to 5.15. I do not remerber which version 28 maybe.
> 
> I still have à RIP in pm_suspend. Did not test the Last two 15 versions.
> 
> I can leave with 5.10 est using own compiled kernels.
> 
> Thanks for asking.

This thread/the debian bug report
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1005005 ) is getting
long which makes things hard to grasp. But to me it looks a lot like the
problem you are facing is different from the problem that others ran
into and bisected -- but I might be totally wrong there. Have you ever
tried reverting 3c196f056666 to seem if it helps (sorry if that's
mentioned in the bug report somewhere, as I said, it became long)? I
guess a bisection from your side really would help a lot; but before you
go down that route you might want to give 5.17 and the latest 5.15.y
kernel a try.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

