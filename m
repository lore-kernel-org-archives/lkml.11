Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 08:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359608AbiFPIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFPIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:05:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CE95D18F;
        Thu, 16 Jun 2022 01:05:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6EC112FC;
        Thu, 16 Jun 2022 01:05:02 -0700 (PDT)
Received: from [10.57.84.206] (unknown [10.57.84.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3173F7F5;
        Thu, 16 Jun 2022 01:04:59 -0700 (PDT)
Message-ID: <7c86f5fb-93fc-b765-8070-35ad21ab8820@arm.com>
Date:   Thu, 16 Jun 2022 09:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 5.15 000/251] 5.15.47-rc2 review
To:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Backlund <tmb@tmb.nu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>
References: <bd80cd0d-a364-4ebd-2a89-933f79eaf4c7@tmb.nu>
 <CAHk-=wix7+mGzS-hANyk7DZsZ1NgGMHjPzSQKggEomYrRCrP_Q@mail.gmail.com>
 <CAHk-=wgfFhwMP0=QQY_iZvf0kveR5=VGK919Ayn+ZSUADs9mag@mail.gmail.com>
 <20220615110022.yifrsvzxjsz2wky5@quack3.lan>
 <20220615133845.o2lzfe5s4dzdfvtg@quack3.lan>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220615133845.o2lzfe5s4dzdfvtg@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 14:38, Jan Kara wrote:
> On Wed 15-06-22 13:00:22, Jan Kara wrote:
>> On Tue 14-06-22 12:00:22, Linus Torvalds wrote:
>>> On Tue, Jun 14, 2022 at 11:51 AM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> Or just make sure that noop_backing_dev_info is fully initialized
>>>> before it's used.
>>>
>>> I don't see any real reason why that
>>>
>>>      err = bdi_init(&noop_backing_dev_info);
>>>
>>> couldn't just be done very early. Maybe as the first call in
>>> driver_init(), before the whole devtmpfs_init() etc.
>>
>> I've checked the dependencies and cgroups (which are the only non-trivial
>> dependency besides per-CPU infrastructure) are initialized early enough so
>> it should work fine. So let's try that.
> 
> Attached patch boots for me. Guys, who was able to reproduce the failure: Can
> you please confirm this patch fixes your problem?
> 
> 								Honza

Works for me too

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
