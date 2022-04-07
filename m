Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 09:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiDGJqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiDGJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:46:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CE214F99
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:43:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 154EF68AFE; Thu,  7 Apr 2022 11:43:56 +0200 (CEST)
Date:   Thu, 7 Apr 2022 11:43:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/debug_vm_pgtable: Drop protection_map[] usage
Message-ID: <20220407094355.GA23320@lst.de>
References: <20220404031840.588321-1-anshuman.khandual@arm.com> <20220404031840.588321-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404031840.588321-2-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
