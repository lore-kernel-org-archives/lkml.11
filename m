Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F29C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 03:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384004AbiDUDuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiDUDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:50:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E03AE7A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:47:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C2B1477;
        Wed, 20 Apr 2022 20:47:14 -0700 (PDT)
Received: from [192.168.225.231] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CCDB3F73B;
        Wed, 20 Apr 2022 20:47:12 -0700 (PDT)
Message-ID: <9859ad1d-9520-f026-328a-e0c29fd3b960@arm.com>
Date:   Thu, 21 Apr 2022 09:17:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220420060221.1107736-1-anshuman.khandual@arm.com>
 <CA+CK2bARgsgBAgawfAD8-xzDN6+_sg4zrPQnoTFy4b=ZMx_u1g@mail.gmail.com>
 <YmDOKJCZteqrKr61@casper.infradead.org>
 <CA+CK2bCYp3+VLLFwrQpC8su1C-NvjdiKs39TFcFh=BTDgB92fQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CA+CK2bCYp3+VLLFwrQpC8su1C-NvjdiKs39TFcFh=BTDgB92fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 09:02, Pasha Tatashin wrote:
> On Wed, Apr 20, 2022 at 11:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Wed, Apr 20, 2022 at 12:54:08PM -0400, Pasha Tatashin wrote:
>>> The rest of EXPORTs were added to be symmetric, and allow other
>>> drivers to use set_*p**()/clear_p** calls.
>>
>> EXPORT_SYMBOLs actually have a real cost.  We don't add them "for
>> symmetry".
> 
> Sure, the rest of exports can be removed, but:
> 
>> -EXPORT_SYMBOL(__page_table_check_pte_set);
> 
> must stay because of
> 
> ERROR: modpost: "__page_table_check_pte_set"
> [drivers/gpu/drm/i915/i915.ko] undefined!

Sure, will resend.
