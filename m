Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 09:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiDGJq0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiDGJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:46:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A095211B30
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:44:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F7A668AFE; Thu,  7 Apr 2022 11:44:16 +0200 (CEST)
Date:   Thu, 7 Apr 2022 11:44:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm/mmap: Clarify protection_map[] indices
Message-ID: <20220407094416.GB23320@lst.de>
References: <20220404031840.588321-1-anshuman.khandual@arm.com> <20220404031840.588321-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404031840.588321-3-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 08:48:40AM +0530, Anshuman Khandual wrote:
> protection_map[] maps vm_flags access combinations into page protection
> value as defined by the platform via __PXXX and __SXXX macros. The array
> indices in protection_map[], represents vm_flags access combinations but
> it's not very intuitive to derive. This makes it clear and explicit.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
