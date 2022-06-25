Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F487C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 07:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFYH74 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiFYH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:59:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D738403D1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:59:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B6CF68AA6; Sat, 25 Jun 2022 09:59:50 +0200 (CEST)
Date:   Sat, 25 Jun 2022 09:59:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [asahilinux:bits/050-nvme 6/9]
 drivers/nvme/host/apple.c:291:19: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <20220625075950.GA22592@lst.de>
References: <202206251551.PTd0wn6d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206251551.PTd0wn6d-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven, can you send a patch to use the proper __le types?  We really
prefer the nvme code to no have any sparse warnings.
