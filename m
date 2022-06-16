Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59571C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 06:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiFPGIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358995AbiFPGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:08:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB625C78
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9IlCM4qscouDgJZ0O1z3XWz1+iaMBhBno5bdb5wFRH8=; b=M8OgglVh3AX1hsPInRYzOJXos9
        SuP6xskoKN4YfAz5d3S2WUsmR+vgytQC6M7HzxKyIraBfBZuYr6kF5e1QnGAE4HdzpfQuMPcp9h36
        8BxfiRzAFYRduVUtPF1YLq1LSAc9Wz45p+p0ylZdIN2oA8rSrwVdEXrqIdo4Kt3oPR4ejgmxEosA0
        +Iyf57annfxAa5EMyqriqPM22o6xIWyl7xgA4hH6wtXfrBdHow11TS/6Lmn/ZEAaCZHwXjp3dZwsZ
        WfQNrPeCfELcXAtZhNAQyagR6ogOL/VqYRVCkUhIAmaBy0gWyq1iYiuAObZ4iOWcJDrUeIFPgdI4V
        RxpNzhRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1ig2-000gS2-Ji; Thu, 16 Jun 2022 06:08:22 +0000
Date:   Wed, 15 Jun 2022 23:08:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] init: Initialize noop_backing_dev_info early
Message-ID: <YqrI1kS/BxEQ+39V@infradead.org>
References: <20220615214815.6901-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615214815.6901-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:48:15PM +0200, Jan Kara wrote:
> +extern int bdi_init(struct backing_dev_info *bdi);

No need for the extern.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

And this remind me that I really want to kill noop_backing_dev_info
and just use a NULL bdi for this case eventually..
