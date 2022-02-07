Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD25C4167E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiBGG6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 01:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBGGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:45:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E485FC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hjWf60JMAVQJhgmfPlSAZ5+/ceseer8Z60uDPAGgkAM=; b=pXzzk49YMnKOxHpmbc1xBRgNAL
        Ujjdd1Q+r1Gjl7lGPov+1N+OOEbrvHtVbAfEyYQO77jxzH84Ia7qA1WQoF9TDMvc9LrfuFSjMzG6i
        6VbmkrhCNvBRqB2CwPGbKMZ3ctisrbKiSjrk3dEGRuBe2APNAlNgfzCxU3OIlk3eBAhCB5n9CbM5b
        Lj49nzeWXJ1EfaM10qescnIfoa8ioXZuDLSRk5Ezh84PAUtgDgGcDB3qotgIrnPIBlEQ6ukIf/VRX
        4G1lvmG8+Ujb3sn2am0knaGYQD+j5rHpvnwNCpFVlcftMRoVJJ09VwRuennleFVgZt60ASDVTbkHQ
        kAtwVylw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxlq-009B91-SM; Mon, 07 Feb 2022 06:45:06 +0000
Date:   Sun, 6 Feb 2022 22:45:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: remove CONFIG_SET_FS
Message-ID: <YgC/8ng5WX6Nt104@infradead.org>
References: <20220206013648.3491865-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206013648.3491865-1-shorne@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 10:36:47AM +0900, Stafford Horne wrote:
> Remove the address space override API set_fs() used for User Mode Linux.

This ain't UML :)

> +	return size <= TASK_SIZE && addr <= (TASK_SIZE - size);

No need for the inner braces.
