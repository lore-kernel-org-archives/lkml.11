Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 22:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiEJW1R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiEJW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:27:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A705005E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DF96B82012
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD04C385CF;
        Tue, 10 May 2022 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652221631;
        bh=xn9WzK9fu3A6Npn1b1LlgCMY2ijWo6q8u9UNkqQPYs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rn2AhrWjky13+Il0y3A/UUvncL0iE/1N7/aI8O18plHJFtPdhyMEA0yn8dp1EbylP
         bVbH9a/kRDaqiKxRksG1Wvl2VmuHBAjl3PlBRVVA5qog9fcmRaVwMIbMMBb/+Sf9+U
         gLPM3nLNh+7SW3ph22kceny+pWy7k67eOxILRm1w=
Date:   Tue, 10 May 2022 15:27:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        skhan@linuxfoundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon : Add documentation for Enum value
Message-Id: <20220510152710.e112088bc5e4722e5cdad41c@linux-foundation.org>
In-Reply-To: <20220509081154.1834-1-sj@kernel.org>
References: <20220508091943.47042-1-sj@kernel.org>
        <20220509081154.1834-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 May 2022 08:11:54 +0000 SeongJae Park <sj@kernel.org> wrote:

> I just found this patch is not cleanly applicable on top of the mm-unstable
> branch[1].  Could you please rebase?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-unstable

I got it.  It was just the DAMON_OPS_VADDR->DAMON_OPS_FVADDR rename.
