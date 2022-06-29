Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiF2Ohw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiF2Ohu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:37:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED334BBB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oDBza5N7USFwJtQwqotpfuFPT2d1pqfC3BCdtwu0nT4=; b=3Yzo41tA7L9FHoEcbdgFrAfzen
        TzKkb2EjCNSnHa05dhNdRVyriVNlGqscm0/SaR09MzQYkW/Bq2xLWpa3iaETKYL7BVMvE3XnOwaaW
        XNWhOd1A9XeDGdHpo9RKOX7bd0koPpT2Ypd2a40wN7RS0/7yYAiuGbSYkqlWR9CI3a51RiDyB0qEp
        Vs2lANV6oktLBnlmI6E8GJDhrRyP80XOyVx6+oLgEi6Pk2NS2OcW8jrMAwwwtaUkEcFwXzaotxgMx
        KtVGX+RCSwR7X/TZDGSqiXo628eO7j9Y/AE3a+TJNcMV0CiYXl8ISuPzQg/2ft9RqekLpjXE362Cv
        7B1MZZUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Yp2-00CX3u-4H; Wed, 29 Jun 2022 14:37:40 +0000
Date:   Wed, 29 Jun 2022 07:37:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     masahiroy@kernel.org, mmarek@suse.cz, paul.gortmaker@windriver.com,
        arnd@arndb.de, rppt@kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to
 IS_ENABLED() and co
Message-ID: <YrxjtLa8kkKi7UWS@infradead.org>
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:56:10AM +0200, Peter Zijlstra wrote:
> 
> Since IS_ENABLED() (and friends) are clearly meant to be used on
> CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> tautology, allow the more compact usage of: IS_ENABLED(foo).

Eww.  Please don't mess up grepability for saving a few characters
of typing.
