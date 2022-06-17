Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED2AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiFQD3i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiFQD3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:29:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF4B864BF0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:29:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9897E12FC;
        Thu, 16 Jun 2022 20:29:35 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26D33F73B;
        Thu, 16 Jun 2022 20:29:32 -0700 (PDT)
Message-ID: <7c72a97f-d7d4-db27-faa5-fec01673cca7@arm.com>
Date:   Fri, 17 Jun 2022 08:59:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Content-Language: en-US
To:     "hch@infradead.org" <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
 <YqrJvV/dWK/iyVvR@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YqrJvV/dWK/iyVvR@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 11:42, hch@infradead.org wrote:
> On Thu, Jun 16, 2022 at 05:45:39AM +0000, Christophe Leroy wrote:
>>> +/* Note due to the way vm flags are laid out, the bits are XWR */
>>> +pgprot_t protection_map[16] = {
>>
>> Was const previously, now back to non const ? Maybe due to a conflict 
>> with linux/mm.h ? At least it should be __ro_after_init.
> 
> Maybe we just need to duplicate vm_get_page_prot in all the
> architectures and thus avoid making protection_map global in a
> common header entirely.  That certainly seems like the cleaner
> interface.

Agreed, also it does free up the platforms to provide any appropriate
qualifiers for the protection_map[] array i.e __ro_after_init, const
etc without impacting generic declaration used in a generic function.
