Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DEFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbiDLK44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356710AbiDLKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2185658
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48A7BCE1C25
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A4C385A1;
        Tue, 12 Apr 2022 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649756515;
        bh=pi+QmDU26pju7mZ8Fvy5R9dpn1wF+2Rumy0pZTv2pgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ilvGxvnkvwBu57bFv3FUrX2dp32y3SHgWtdPrIddztOZQet2W4VmhdmcvAyjutvFe
         p4sfXzs1aUNXmoX37Uov4GvETy9t1DX/0L7U+1ryZOZqDAa9d8FEkJM2ezeOYkmUS2
         L3lZVodMWYTrkoJ7wFvV7F9sVJZ2ljCH1fyKkMLu/vg0SzyiaqIE30H9c/EOmYnPPZ
         Cwfgy6SENRltROBLMdu/e1fSBtUSpPDOK7DYeigIS2hSvxK7ofwOEXWNP+z0DH4glB
         vwYk+Wc7UCPgirQh1aqaBWlxPtHrPHSzSOeAmlhafxOWUrtjn32kM7iZfNQW/nlvDj
         pe61lKkOclNlw==
Message-ID: <4fe435c4-6b6f-0223-66b8-45f9549cdc52@kernel.org>
Date:   Tue, 12 Apr 2022 17:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] f2fs: replace usage of found with dedicated list
 iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
 <20220331221650.891790-2-jakobkoschel@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220331221650.891790-2-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/1 6:16, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
