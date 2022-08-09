Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC59C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 00:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiHIAdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHIAde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC319C0F;
        Mon,  8 Aug 2022 17:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C73861117;
        Tue,  9 Aug 2022 00:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3165C433C1;
        Tue,  9 Aug 2022 00:33:30 +0000 (UTC)
Message-ID: <c42ca36d-3535-bd31-e965-2b86840a03f7@linux-m68k.org>
Date:   Tue, 9 Aug 2022 10:33:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.20
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.20.

Just a few small changes this time. Spelling fix, sparse warning fix and
a fix for compilation with flexcan driver enabled on hardware without that
hardware block.

Regards
Greg




The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

   Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.20

for you to fetch changes up to 472e68df4a5eacdbe4fd07cffef1b5ffdd95516b:

   m68k: Fix syntax errors in comments (2022-07-25 09:01:09 +1000)

----------------------------------------------------------------
Fixes include:
. spelling in comment
. compilation when flexcan driver enabled
. sparse warning

----------------------------------------------------------------
Randy Dunlap (1):
       m68k: coldfire/device.c: protect FLEXCAN blocks

Wang Jingjin (1):
       m68k: coldfire: make symbol m523x_clk_lookup static

Xiang wangx (1):
       m68k: Fix syntax errors in comments

  arch/m68k/coldfire/device.c | 6 +++---
  arch/m68k/coldfire/intc-2.c | 2 +-
  arch/m68k/coldfire/m523x.c  | 2 +-
  3 files changed, 5 insertions(+), 5 deletions(-)

