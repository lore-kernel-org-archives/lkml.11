Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 04:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiE3EJM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 00:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE3EJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 00:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CF12D25;
        Sun, 29 May 2022 21:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC1760C97;
        Mon, 30 May 2022 04:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB68CC3411A;
        Mon, 30 May 2022 04:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653883743;
        bh=O1ZrbSazZygwObbPDXW9M9dTNwrqFTl5sYyv7t5yDto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+k9l7y+lTOwDWSPvTOUqbNsHjPh2iN2kpo+yqUJKntow+t+lfaMB87NYIky2SAAU
         5CYlRq8L5A3og5CZB8D2naZQdiiiF3BY/U8oY88eT1seOOZdK759NU2nlDRvQPhrMT
         oEv/OQSxSbjD36EtnuimMFCOT/5rEkS20o1tZbkg2rwllbdwKfzxBsjaD1uqHUY0yS
         vdUQJQC7TbEl4aIFkBSQn8I2XsbdBQb9ADlqYjxvj/WYGLI9Y4Ns87X0yZd09JTcRs
         bKuqpgIXj1RFmq/WjZ2OqnVrSLr9D27yuNHcGCuEf6XpGCeLQ4PtrE7Kud3GdD0UvJ
         QREy0/lQaH3tQ==
Date:   Mon, 30 May 2022 00:09:01 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, linux-parisc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 2/8] parisc: Disable debug code regarding
 cache flushes in handle_nadtlb_fault()
Message-ID: <YpRDXQhHplJFwSxy@sashalap>
References: <20220524160035.827109-1-sashal@kernel.org>
 <20220524160035.827109-2-sashal@kernel.org>
 <786f58e8-aa61-d439-c9bb-4a27599d2aa5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <786f58e8-aa61-d439-c9bb-4a27599d2aa5@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:44:59PM +0200, Helge Deller wrote:
>Hello Sascha,
>
>On 5/24/22 18:00, Sasha Levin wrote:
>> From: John David Anglin <dave.anglin@bell.net>
>>
>> [ Upstream commit 67c35a3b646cc68598ff0bb28de5f8bd7b2e81b3 ]
>>
>> Change the "BUG" to "WARNING" and disable the message because it triggers
>> occasionally in spite of the check in flush_cache_page_if_present.
>
>Please drop this patch from the backporting-queue (v5.10, v5.15 and v5.17).
>It's not necessary since the warning will only trigger on v5.18 on machines
>with PA8800/PA8900 processors.

Will do, thanks.

-- 
Thanks,
Sasha
