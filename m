Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D71FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 19:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiESTsr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiESTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:48:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3076F1340
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:48:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA1A168B05; Thu, 19 May 2022 21:48:38 +0200 (CEST)
Date:   Thu, 19 May 2022 21:48:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, Jason@zx2c4.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Message-ID: <20220519194838.GA6361@lst.de>
References: <20220519193133.194138-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519193133.194138-1-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:31:31PM -0600, Jens Axboe wrote:
> Hi,
> 
> We recently had a failure on a kernel upgrade because splice no longer
> works on random/urandom. This is due to:
> 
> 6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> 
> which already has more than two handful of Fixes registered to its
> name...

Yes.  It was a hard break to get rid of set_fs and it's abuse.
