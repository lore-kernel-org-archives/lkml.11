Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1721C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 12:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiEYMq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243198AbiEYMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:46:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4DE90CFD;
        Wed, 25 May 2022 05:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9134DB81D7A;
        Wed, 25 May 2022 12:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4565C385B8;
        Wed, 25 May 2022 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653482811;
        bh=SdlbktbuC9eG2ydg+y5IaluIYwwH7xBmLSardkTKGfs=;
        h=From:To:Cc:Subject:Date:From;
        b=i8WqmNoEsfA6lAe+1W6Mj9KIhhZK/LwySPcQkughvg05VGmf39Sn2p1Hi0CaSMxIO
         mZyns1U+4w5lW1W6xfO0YP24vNc+Y47ckGDo1o4Gdt2R2b5KX9TyqIoOKSA/VgfKY8
         OIyMpFk+fjH+AVaKJtBeaW3GkrDc+dgEuH8Znuiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.17.11
Date:   Wed, 25 May 2022 14:46:44 +0200
Message-Id: <165348280438163@kroah.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.17.11 kernel.

All users of the 5.17 kernel series must upgrade.

The updated 5.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile             |    2 +-
 net/mptcp/protocol.h |    3 ++-
 net/mptcp/subflow.c  |   21 ++++++++++++++++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.17.11

Mat Martineau (1):
      mptcp: Do TCP fallback on early DSS checksum failure

