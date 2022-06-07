Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiFGKQZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiFGKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:16:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB2EBAAC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:16:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9498267373; Tue,  7 Jun 2022 12:16:18 +0200 (CEST)
Date:   Tue, 7 Jun 2022 12:16:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix syntax errors in comments
Message-ID: <20220607101618.GA23881@lst.de>
References: <20220604143254.15638-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604143254.15638-1-wangxiang@cdjrlc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.19.
