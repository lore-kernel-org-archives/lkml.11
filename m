Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C6C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 12:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359774AbiFPMTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiFPMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:19:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2DA49929;
        Thu, 16 Jun 2022 05:19:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1144011FB;
        Thu, 16 Jun 2022 05:19:15 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B063F73B;
        Thu, 16 Jun 2022 05:19:14 -0700 (PDT)
Message-ID: <582e4c0b-5cd3-7fac-cba7-7250a458a60d@arm.com>
Date:   Thu, 16 Jun 2022 13:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory
 region
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>
Cc:     Matt Ranostay <mranostay@ti.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220616105112.289719-1-mranostay@ti.com>
 <9b005c7d-e434-c215-288d-3926f483b07a@arm.com> <87y1xw3iy9.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87y1xw3iy9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-16 13:13, Marc Zyngier wrote:
> On Thu, 16 Jun 2022 13:07:23 +0100,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-06-16 11:51, Matt Ranostay wrote:
>>> GICD region was overlapping with GICR causing the latter to not map
>>> successfully, and in turn the gic-v3 driver would fail to initialize.
>>>
>>> This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
>>> replaced of_iomap() calls with of_io_request_and_map() that internally
>>> called request_mem_region().
>>>
>>> Respective console output before this patchset:
>>>
>>> [    0.000000] GICv3: /bus@100000/interrupt-controller@1800000: couldn't map region 0
>>
>> Oh, it's nice that this finds bugs, but it seems I hadn't fully
>> considered that making the simple easy change in the DT paths results
>> in different behaviour from ACPI.
>>
>> Marc, would you like a fix for this to remain non-fatal even in the
>> face of a dodgy DT, or are you happy with being a bit stricter now?
> 
> I'd rather we work around it. I shout at people for breaking existing
> DTs, so this should apply to the GIC as well. A nice WARN_ON_ONCE()
> should do, if you don't mind writing the patch.

Indeed, I think that would be my default preference as well - apologies 
for the oversight! I'll spin the patch shortly (and make the warning 
consistent for the ACPI side too).

Cheers,
Robin.
