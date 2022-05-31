Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB502C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 22:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348336AbiEaWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348331AbiEaWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:10:46 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EE9CF4F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:10:41 -0700 (PDT)
X-ASG-Debug-ID: 1654035038-1cf43917f334d340001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id pi5n3chlKhW5dG70; Tue, 31 May 2022 18:10:38 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=Pscrfy4zfmI9B2/f3RlaAfD71lZsuhWSoCA2Yk9IIwI=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=q5PB8adp564e7QMu+Y67
        rqxW9A2//yQphTVtYoOJzENI1mQv1RQmgvsm7Lip7aY8a7rF+htFUguM3OldCVKcojJicdxPHrfCe
        RfT8TUxLI1Q2o5QHc1BeFYM3K6ctZm0dHzpcsepgcE3x6eZwrBlQGNCsc3NwiuaJ4K8luj2hLA=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11830524; Tue, 31 May 2022 18:10:38 -0400
Message-ID: <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
Date:   Tue, 31 May 2022 18:10:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
 <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654035038
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 989
X-Barracuda-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 17:54, Keith Busch wrote:
> On Tue, May 31, 2022 at 02:23:44PM -0400, Tony Battersby wrote:
>> dma_pool_free() scales poorly when the pool contains many pages because
>> pool_find_page() does a linear scan of all allocated pages.  Improve its
>> scalability by replacing the linear scan with a red-black tree lookup.
>> In big O notation, this improves the algorithm from O(n^2) to O(n * log n).
> The improvement should say O(n) to O(log n), right?

That would be the improvement for a single call to dma_pool_alloc or
dma_pool_free, but I was going with the improvement for "n" calls
instead, which is consistent with the improvement for the example in the
cover letter for mpt3sas.  I would have to look up the convention to be
sure of the proper notation in a situation like this, but I usually
think "inserting N items takes N^2 time"; to me it makes less sense to
say "inserting 1 item takes N time", because the N seems to come out of
nowhere.

Tony

