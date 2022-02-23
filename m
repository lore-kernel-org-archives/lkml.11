Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 00:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiBWAHO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBWAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:07:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5332F;
        Tue, 22 Feb 2022 16:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gn7VX6NcCSnnWpzXISJ6YEhhClDI/b+YJQ1Q15ZLTI0=; b=QeHhToOsm5NH3+gAlvUonK5hRB
        /yZ1MpKHVhAK4lS2kKdQLPZqmh6+Tm8GVhJp+gfRJxYxpRKmKsXJ9Wju9dN6i2QHbL46uZWcdD91L
        VWaOTYCk4Y19dm4gmLrFbgZo43f4BUQL0uuktZ3pXnV3BQCDeGAo3MA1hWZ3OdWzNNBzGHD2aEZEl
        eRFUtcajeM7EpG6So50hUxQ+7W2nrdK8VFHYMAc7WDh4pQlV5sQrIjnritpxDf3JJxeV/AYJjB3T0
        M08WGM0ARyj5hv/JqNUo2cCjRE51K6bbnadFOeN3FeddpMq0W0eOUEtweYYGzYaozZlHprKjWh4I3
        MydQYtnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfAq-00C0NO-V7; Wed, 23 Feb 2022 00:06:28 +0000
Date:   Tue, 22 Feb 2022 16:06:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     broonie@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sujiaxun <sujiaxun@uniontech.com>,
        tangmeng <tangmeng@uniontech.com>,
        zhanglianjie <zhanglianjie@uniontech.com>,
        Zhen Ni <nizhen@uniontech.com>
Subject: Re: linux-next: manual merge of the sysctl tree with the tip tree
Message-ID: <YhV6hKamk3DRILPu@bombadil.infradead.org>
References: <20220222235218.906101-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222235218.906101-1-broonie@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:52:18PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the sysctl tree got conflicts in:
> 
>   include/linux/sched/sysctl.h
>   kernel/sysctl.c
> 
> between commit:
> 
>   c8eaf6ac76f40 ("sched: move autogroup sysctls into its own file")

Peter, would you prefer if I just take this one commit? The syctl
changes keep coming. Let me know!

  Luis
