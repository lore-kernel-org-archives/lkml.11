Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE352C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jan 2022 14:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389125AbiAYOqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:46:22 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43481 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1579916AbiAYOlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:41:04 -0500
Received: from [192.168.0.2] (ip5f5aeaa2.dynamic.kabel-deutschland.de [95.90.234.162])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA43161E6478B;
        Tue, 25 Jan 2022 15:40:54 +0100 (CET)
Message-ID: <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
Date:   Tue, 25 Jan 2022 15:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page
 fault
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Zha Qipeng <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org,
        Andy Pont <andy.pont@sdcsystems.com>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
 <YfAIrkJaahKpCta6@lahna>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YfAIrkJaahKpCta6@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: +Andy]

Dear Mika,


Am 25.01.22 um 15:26 schrieb Mika Westerberg:

> On Tue, Jan 25, 2022 at 02:08:53PM +0100, Paul Menzel wrote:

>> `intel_pmc_get_resources()` does not set the name member in the `resource`
>> struct `gcr_res` resulting in a page fault.
> 
> On which system you reproduce this,

The dump contains the name:

     Hardware name: Star Labs Lite/Lite, BIOS 8 01/24/2022

> and how? Can you also share ACPI dump from that system.

Note, I only forwarded this from a report in #coreboot. The reporter 
Andy is now in Cc.

Unrelated from that information, the Linux kernel should never run into 
a page fault and not trust system data.


Kind regards,

Paul
