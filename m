Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2776ECAAD1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 17:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiH3Rrv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiH3RrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:47:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2265A836;
        Tue, 30 Aug 2022 10:43:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B461042;
        Tue, 30 Aug 2022 10:29:55 -0700 (PDT)
Received: from [10.57.15.35] (unknown [10.57.15.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 531493F7B4;
        Tue, 30 Aug 2022 10:29:47 -0700 (PDT)
Message-ID: <89287d36-5b29-5fba-db6c-dd1b116489e6@arm.com>
Date:   Tue, 30 Aug 2022 18:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] coresight: etm4x: Expose default timestamp source
 in sysfs
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <20220823160650.455823-1-james.clark@arm.com>
 <20220826195552.GA1991601@p14s>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220826195552.GA1991601@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2022 20:55, Mathieu Poirier wrote:
> On Tue, Aug 23, 2022 at 05:06:48PM +0100, James Clark wrote:
>> I've taken over this one from German because he's moved to a different
>> team. I gave it a quick check and bumped the version number in the docs
>> for the next release, but the month is an estimate.
>>
>> Thanks
>>
>> Changes since v2:
>>
>>   * Rebased onto coresight/next (b99ee26a1a)
>>   * Bumped release version to 6.1
> 
> I have applied this set.  Usually I'd let Suzuki handle it since he is already
> familiar with the work but 1) he is currently away and 2) the patchset is fairly
> simple.

Thanks Mathieu

> 
> Thanks,
> Mathieu
> 
>>
>> Changes since v1:
>>
>>   * Inline etmv4_to_ts_source() function.
>>   * Collect review tag from Leo.
>>
>> German Gomez (2):
>>   coresight: etm4x: Expose default timestamp source in sysfs
>>   coresight: etm4x: docs: Add documentation for 'ts_source' sysfs
>>     interface
>>
>>  .../testing/sysfs-bus-coresight-devices-etm4x |  8 +++++
>>  .../coresight/coresight-etm4x-reference.rst   | 14 +++++++++
>>  arch/arm64/include/asm/sysreg.h               |  1 +
>>  .../coresight/coresight-etm4x-sysfs.c         | 29 +++++++++++++++++++
>>  4 files changed, 52 insertions(+)
>>
>> -- 
>> 2.28.0
>>
