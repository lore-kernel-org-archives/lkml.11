Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC255C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351462AbiFUNsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350518AbiFUNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:48:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DC63CB;
        Tue, 21 Jun 2022 06:48:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CE3A68AA6; Tue, 21 Jun 2022 15:48:38 +0200 (CEST)
Date:   Tue, 21 Jun 2022 15:48:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hounschell <markh@compro.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Message-ID: <20220621134837.GA8025@lst.de>
References: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:43:18AM -0400, Mark Hounschell wrote:
> Revert that commit and all works like normal. This commit breaks user land.

No.  We had that discussion before.  It exposeѕ how broken your out of
tree driver is, which you don't bother to fix despite Robin even taking
the pains to explain you how.
