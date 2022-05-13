Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E7C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbiEMGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiEMGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22415EDFD;
        Thu, 12 May 2022 23:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A88461CF4;
        Fri, 13 May 2022 06:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FB5C34100;
        Fri, 13 May 2022 06:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652422160;
        bh=QtiDiI1n46PbHkwlg0EA/tlSMFio0/x0qUiQn8o/2jk=;
        h=Date:From:To:Cc:Subject:From;
        b=dfWVXj7qrJzymsDGmgVQHBCqZMtyyc/aYqihi6PPGcm/LBTT4TU0NAqYDSwxrDJZS
         7kPEB7/gPkRUa/BTfVzvG/8T7DuBWslHmFdHqDet4JWJdtIEqCu77+v+gESnTC83Zk
         d02jWqx2FXpelGj05dEWICsjr0qSkOwLRcXEGC2QFjsi1nBZyy+q/rmyULc/HvE4HC
         bxrbcQ6weKyNPgxLaPhKosm9WY2XcV2H+Nue5fsfBYDoMZgmZx54a1qPzLAP3tgfg1
         /Ahg1TuO2Ev/EcKL18Ec/4LOZEVmwLnkvo1yVtloTYaFGxYAPDiwxFzClLomwjemTb
         vUi+XqYyAtEng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npOUG-00063n-Tq; Fri, 13 May 2022 08:09:16 +0200
Date:   Fri, 13 May 2022 08:09:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.18-rc7
Message-ID: <Yn32DMmVNRmT0zz2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.18-rc7

for you to fetch changes up to 870b1eee2d844727b06e238c121d260bc5645580:

  USB: serial: qcserial: add support for Sierra Wireless EM7590 (2022-05-05 15:15:15 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.18-rc7

Here are some new device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Ethan Yang (1):
      USB: serial: qcserial: add support for Sierra Wireless EM7590

Scott Chen (1):
      USB: serial: pl2303: add device id for HP LM930 Display

Sven Schwermer (2):
      USB: serial: option: add Fibocom L610 modem
      USB: serial: option: add Fibocom MA510 modem

 drivers/usb/serial/option.c   | 4 ++++
 drivers/usb/serial/pl2303.c   | 1 +
 drivers/usb/serial/pl2303.h   | 1 +
 drivers/usb/serial/qcserial.c | 2 ++
 4 files changed, 8 insertions(+)
