Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34925C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 18:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiF3S3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiF3S3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:29:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A530567
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:29:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8CEF68AA6; Thu, 30 Jun 2022 20:29:37 +0200 (CEST)
Date:   Thu, 30 Jun 2022 20:29:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org, hch@lst.de,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v2] pmem: fix a name collision
Message-ID: <20220630182937.GA19534@lst.de>
References: <20220630182802.3250449-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630182802.3250449-1-jane.chu@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
