Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0DEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 06:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiC2GTV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiC2GTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:19:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FFD248780;
        Mon, 28 Mar 2022 23:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=J5UAbNwy8KlDnn+Z4/t0iMzruC
        viTKtpQIAJZ5Yg8JzRqiQnooLTwegYOzcl9zxfL0X3cRZdjEboF/RsB2oV4FAb6vq6hJ6sK/iEsnA
        y1qP8xYjbucxYkeXbWwa6U2R//uYyEmpWy1bxTUiH/E3Zrxizw9ftzNHQW71oHC94naSzlvxuZf8v
        ZMOgcNKfm6Gi5bm4Is59j51rVHtwt6zu0HSt1ksVoOhvDus3cwFPdMzZQHVrxCY0j9ze6N7U8tkGp
        xWEwTQzyQDShIj0xLAsghV7PLPUsvSjkyzBmC5xiGw51etwrVGSC1KKEq3c6hB8qOYazA+QOerBv+
        mRQJs4Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ5AX-00BBTB-Eg; Tue, 29 Mar 2022 06:17:29 +0000
Date:   Mon, 28 Mar 2022 23:17:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     djwong@kernel.org, fangwei1@huawei.com, houtao1@huawei.com,
        hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: fix an infinite loop in iomap_fiemap
Message-ID: <YkKkeW48ZMBQKapS@infradead.org>
References: <20220320162641.GB8182@magnolia>
 <20220329032957.2694944-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329032957.2694944-1-guoxuenan@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
