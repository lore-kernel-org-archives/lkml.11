Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 02:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbiFWCup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 22:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiFWCun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20513DC4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD44161D7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE13C3411B;
        Thu, 23 Jun 2022 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655952642;
        bh=tdjqAoX1yhdrpIxkENpUPLNuE3udmL20asfAlDU2UE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NR3MzgCn0M9xNzjgxW4DiNcaOfjdT5xFRtXSTrKhRwh1aJwGJKt8OJL/qjU6zyigi
         RM3/yl9kLN18sxoibaHEn1e3iQytkmw/XaJ8B/ytfU+jZ5ZfBq+HCN9PkWuRU194wB
         j9yTm+cUfV/zhqRESBgpGvydNhFCDiGr3U6PMr1AUWC+JeCVtfl+nhV6arfj0nAnw+
         J+rHO7BpVtp6p7MsxJNnGVx1EOghJYS9H++U3TmWfP9txP1vjbDPEzKULbe6m1cF2n
         mYGAEq8U30ZG/nnRTeF+P+uHHG6H2gOFl19EAO0mh5482rrfEDVGlnk8kK9bpDhcFb
         d+ChdDrBk5fhA==
Message-ID: <d104124c-5196-bc80-b3e3-0ab55f0cc35e@kernel.org>
Date:   Wed, 22 Jun 2022 19:50:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     vgupta@kernel.org, Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <YrLTCXLrr3HB39lv@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 01:30, Bagas Sanjaya wrote:
>> - * If the U-mapping is not congruent to to K-mapping, former needs flushing.
>> + * If the U-mapping is not congruent to K-mapping, former needs flushing.
>>    */
>>   void flush_dcache_page(struct page *page)
>>   {
> The patch is OK, but its subject is wrong.

Right.

> The patch above isn't fixing any syntax errors, but rather minor cleanup.
> The subject should have been "Remove duplicate 'to' in the
> flush_dcache_page() comment".

I'd just say "ARC: mm: fix typos"

> I think that this kind of cleanup patches (typofixes) are best done
> as part of **actual** work on the code in question (for example
> refactoring or fixing build errors).

In an ideal world yes. But sometimes maintainer complain to break 
whitespacxe fixes and such into independent fix. Also as someone said 
later in the thread, for somebody just getting into kernel and figuring 
out patch submission etc this could be a perfect dry run and helps 
improve the code anyways.

-Vineet
