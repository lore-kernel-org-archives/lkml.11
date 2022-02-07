Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiBGHws (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243369AbiBGHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:51:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BAC043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=0ob+OxRreeni0Nq7IPHco08zZw
        cXp0AjzZIG4fuYS189mcAHoRiC5lIllS8lY0W6fylNGK1/zMjP/f7HG2xLwwwejotMQz3/Y3iX6h0
        xuPkwMvJcc+gI0xqbEzBX5xastCRdCwMrO2iY87BX0XJwTqLuqIc9vMxheaO+x98ddLx9ilF2Q/Iv
        xYJ9tgm5Mx911C17bl4IkiaAngQ8g+e9o8oC80AhTv7mENBTWta3mKlXWlSRfe3laPXTrtaJeu9vL
        jQ6Mzlmq3cm8wSIiGhV+Bzk3lM2yXleAzym0s6j2A+OGS8MZK8N7KegENlRfRTmciHbEQMJnthRex
        MTGUX/Gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGynm-009Fu5-Gg; Mon, 07 Feb 2022 07:51:10 +0000
Date:   Sun, 6 Feb 2022 23:51:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/75] mm/vmscan: Convert __remove_mapping() to take a
 folio
Message-ID: <YgDPbo8UGAmwZqy2@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-34-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
