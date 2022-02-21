Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD83C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381055AbiBUQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:46:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381105AbiBUQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDEB21E1B;
        Mon, 21 Feb 2022 08:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C824B61333;
        Mon, 21 Feb 2022 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BEAC340E9;
        Mon, 21 Feb 2022 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645461926;
        bh=W7ezVQTUFoKTFZqSLf9/SW2t8JW8quXVxRRaX1BAWjw=;
        h=From:To:Cc:Subject:Date:From;
        b=je7yJle+E8JUsS7ZvIOiyhK5sdhBdBEZSCXVDVBB8KKyx03bZQXnMqQs7o1GolKSI
         5h51WYOY9zD6p+xbkaK76bSmjV1QjgshGYELkgYB/x7YxJQX/QXzc8irjmnpipxj1q
         IvSNPRaoYiiQTnyzaq3npGiDpjBjV1J/5Um1om7u+7sVgP5CdHVDFTW3nEwPgqYLIj
         PSgVKYZC5DSKLduquOAxvCRSTaBNrfkS1oY69fdCX8ZmGjQXxIsb1zMF4FSC/doON0
         fXhTeHcUVAfDJGWfroEpeFQVDXlEjap+uhUTUNtNgWM6B6AbP8oE20GuZSamf+6Prr
         tWxvtyCthkm6A==
From:   broonie@kernel.org
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: linux-next: manual merge of the block tree with the fscrypt tree
Date:   Mon, 21 Feb 2022 16:45:15 +0000
Message-Id: <20220221164515.2413265-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the block tree got a conflict in:

  fs/iomap/direct-io.c

between commit:

  489734ef94f4f ("iomap: support direct I/O with fscrypt using blk-crypto")

from the fscrypt tree and commit:

  07888c665b405 ("block: pass a block_device and opf to bio_alloc")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.
