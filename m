Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8E6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 09:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiFIJyY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiFIJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865119425B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C952C61CE3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2D4C3411B;
        Thu,  9 Jun 2022 09:54:14 +0000 (UTC)
Date:   Thu, 9 Jun 2022 10:54:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 1/4] mm: kmemleak: add OBJECT_PHYS flag for objects
 allocated with physical address
Message-ID: <YqHDQ2MOJ1RG9LLA@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-2-patrick.wang.shcn@gmail.com>
 <Yp3rO4WpLzxLA6+7@arm.com>
 <8fc24ba3-1467-b845-a70e-7ed77750e6cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc24ba3-1467-b845-a70e-7ed77750e6cd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:32:26PM +0800, Patrick Wang wrote:
> The leak check could be taken on physical objects. Conversion
> of block address from virtual to physical before lookup should
> make this work (this is useless currently). I think we'd better
> know about this.

Yes, we could add this, but since all the phys objects are currently
'gray', it won't make any difference, other than an extra lookup in the
phys tree.

-- 
Catalin
