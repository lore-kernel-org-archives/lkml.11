Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CBDC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 19:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiFMTe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiFMTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:34:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C773DA73
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:58:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDC2068AFE; Mon, 13 Jun 2022 19:58:16 +0200 (CEST)
Date:   Mon, 13 Jun 2022 19:58:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rasheed.Hsueh@lcfuturecenter.com, wuxy23@lenovo.com,
        gwendal@chromium.org, rasheed.yh@gmail.com
Subject: Re: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC
 and Samsung SSDs
Message-ID: <20220613175816.GD15847@lst.de>
References: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com> <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.19.
