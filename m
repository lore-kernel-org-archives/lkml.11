Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21812C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352384AbiCUTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352369AbiCUTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:02:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409013EB81
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:00:34 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nWNGY-0001D5-7r; Mon, 21 Mar 2022 20:00:31 +0100
Message-ID: <b3c39447-c02a-a021-8a4f-499aa962980c@leemhuis.info>
Date:   Mon, 21 Mar 2022 20:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
Content-Language: en-US
To:     dod@debian.org, Eric Valette <eric.valette@free.fr>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Sasha Levin <sashal@kernel.org>, David Airlie <airlied@linux.ie>,
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
 <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com>
 <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
 <3873010.MHq7AAxBmi@ylum>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <3873010.MHq7AAxBmi@ylum>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1647889234;f9afec0b;
X-HE-SMSGID: 1nWNGY-0001D5-7r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 19:49, Dominique Dumont wrote:
> On Monday, 21 March 2022 09:57:59 CET Thorsten Leemhuis wrote:
>> Dominique/Salvatore/Eric, what's the status of this regression?
>> According to the debian bug tracker the problem is solved with 5.16 and
>> 5.17, but was 5.15 ever fixed?
> 
> I don't think so.
> 
> On kernel side, the commit fixing this issue is
> e55a3aea418269266d84f426b3bd70794d3389c8 . 
> 
> According to the logs of [1] , this commit landed in v5.17-rc3
> 
> HTH
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

And from there it among others got backported to 5.15.22:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.15.y&id=8a15ac1786c92dce6ecbeb4e4c237f5f80c2c703

https://lwn.net/Articles/884107/

Another indicator that Eric's problem is something else.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.


