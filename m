Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 12:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiEKMp5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiEKMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:45:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5928426CF;
        Wed, 11 May 2022 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IuWS9dpIvB8V2t76o3BjxsIfNlJCTwJh4ct18MVXL7M=; b=Vs1EtqBVeV8SccoLlEuveq9n0l
        lJUnRf8Gi+QOatP+JAM+fhr+S+4QoYtxsKcnfeYDzaZz4dGyF0vQuR3FPiSYgRbbE2sO7lLfOXylP
        uGaQt1OuXUdCZL/MBCbjH66WECCzdQCN21G0PYAuJKxd8XYe6t88QBbqk34VkM7JkqDIzrGfRtq4V
        r6X72778s/pNpFI+CWfLnhF8qRUkmu5l/o1yq8OdVHIBluZYEVVb7rkvtCSBZOzglu3fSp47eMDjU
        2RZgMoKCHdhOl75uA5kKWF61oc6Vdw6JenDGY55AfunHcu3+cjUzdJp7wsNawfskVnGkX7tFQoi91
        Ph7ezhhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nolin-006pKm-CQ; Wed, 11 May 2022 12:45:41 +0000
Date:   Wed, 11 May 2022 05:45:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhanghongtao (A)" <zhanghongtao22@huawei.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linfeilong@huawei.com, suweifeng1@huawei.com,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH] drivers:uio: Fix system crashes during driver switchover
Message-ID: <Ynuv9YJPE0tO4347@infradead.org>
References: <d204cc88-887c-b203-5a5b-01c307fda4fb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d204cc88-887c-b203-5a5b-01c307fda4fb@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought SPDK uses vfio?  Using uio for anything that does DMA is
completelz unsafe.
