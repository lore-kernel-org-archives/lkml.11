Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8850CC00140
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiHMCku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMCkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 22:40:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B908B99F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BlfgV8HtMySJmFZBqWSSIw/CZQYPoON2S+sB6/la0Ss=; b=IOtl5eEv2dbGGfmqy4ESbweGsk
        EmJ8spyjKZ5Z3+tOna4Rom1FvW7AQPwFluzybL0GU7lqXN7rtELqExrGb3LrlcJ7254y9OF9xaivH
        g+if2+xiPIHiDhPIAuW94u4lkGeqjeAfPg7MD/cK96LXRkKdeNuFomQcpVppXlR36T6c+NHAAY38R
        hl6GreSwf2AwBzNCY4aP7EZi7+nvJYy+gdWwZ7z2Msx9g7rZ4fKTUQcDaF5rEpXR/w6dcIY+B2Byt
        VNXEpf883dtfi4BflLk+C79pv4a6+iBdaXslh1TRRf0XHgVQZ6hUbYlokM/W+NLKr+CCj5XEZpCUc
        7GJ2TTpw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMh4e-003XS2-1z; Sat, 13 Aug 2022 02:40:28 +0000
Message-ID: <c2565611-d8c8-5eb1-2b8f-58da7f86ecbe@infradead.org>
Date:   Fri, 12 Aug 2022 19:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 09/12] mm: Make MAX_ORDER of buddy allocator
 configurable via Kconfig SET_MAX_ORDER.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        James Houghton <jthoughton@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20220811231643.1012912-1-zi.yan@sent.com>
 <20220811231643.1012912-10-zi.yan@sent.com>
 <becc0751-9ce9-6fab-8e58-477e962e54c5@infradead.org>
 <25D8229F-CFB1-46FE-B4C8-7D2EBEAB10AC@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <25D8229F-CFB1-46FE-B4C8-7D2EBEAB10AC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/22 19:37, Zi Yan wrote:
> 
> On 12 Aug 2022, at 21:11, Randy Dunlap wrote:
> 
>> Hi--
>>
>> On 8/11/22 16:16, Zi Yan wrote:
>>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index bbe31e85afee..e558f5679707 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -441,6 +441,20 @@ config SPARSEMEM_VMEMMAP
>>>  	  pfn_to_page and page_to_pfn operations.  This is the most
>>>  	  efficient option when sufficient kernel resources are available.
>>>
>>> +config SET_MAX_ORDER
>>> +	int "Set maximum order of buddy allocator"
>>> +    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER = 0)
>>> +	range 10 255
>>> +	default "10"
>>> +	help
>>> +	  The kernel memory allocator divides physically contiguous memory
>>> +	  blocks into "zones", where each zone is a power of two number of
>>> +	  pages.  This option selects the largest power of two that the kernel
>>> +	  keeps in the memory allocator.  If you need to allocate very large
>>> +	  blocks of physically contiguous memory, then you may need to
>>> +	  increase this value. A value of 10 means that the largest free memory
>>> +	  block is 2^10 pages.
>>
>> Please make sure that all lines of help text are indented with one tab + 2 spaces,
>> as specified in Documentation/process/coding-style.rst.
> 
> I guess you mean the wrong indentation of "depends on" here, since all
> the help text is correctly indented. Thanks. I fixed it locally.

Oops, yes. Thanks.

-- 
~Randy
