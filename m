Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8136C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 19:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiEaTwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEaTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:52:45 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DE8FD47
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:52:42 -0700 (PDT)
X-ASG-Debug-ID: 1654026760-1cf43917f334bc90001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id QMvSFwNwLMI2vW0s; Tue, 31 May 2022 15:52:40 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=zaY0KN5bbdhdGj5w5iqbSpBFgDXMIwvTrwlB06Godyg=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=IFInqWoaVpE2F1jFz/+r
        jyb5wPZuz63wZQg6jpwm5m5ElcALvbK5NO5QskKNmwuWJqfKc7YaZ42NFF6+NjJ5DgR2mrihQ4ZoU
        x8Ap/beCyzlKBxutxj/P1Vc3ktqab1UlduPF13iLWKWhPHdW1PP3PM6YtKmCrknWqgNBRiomNQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829739; Tue, 31 May 2022 15:52:40 -0400
Message-ID: <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
Date:   Tue, 31 May 2022 15:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
To:     Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
 <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654026760
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 15:48, Robin Murphy wrote:
> On 2022-05-31 19:17, Tony Battersby wrote:
>
>>   				 pool->name, blocks,
>> -				 (size_t) pages *
>> -				 (pool->allocation / pool->size),
>> +				 (size_t) pages * pool->blks_per_alloc,
>>   				 pool->size, pages);
>>   		size -= temp;
>>   		next += temp;
>> @@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>>   	retval->size = size;
>>   	retval->boundary = boundary;
>>   	retval->allocation = allocation;
>> +	retval->blks_per_alloc =
>> +		(allocation / boundary) * (boundary / size) +
>> +		(allocation % boundary) / size;
> Do we really need to store this? Sure, 4 divisions (which could possibly 
> be fewer given the constraints on boundary) isn't the absolute cheapest 
> calculation, but I still can't imagine anyone would be polling sysfs 
> stats hard enough to even notice.
>
The stored value is also used in patch #5, in more performance-critical
code, although only when debug is enabled.

Tony

