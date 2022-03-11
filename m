Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0602AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 19:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351119AbiCKTcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiCKTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:32:14 -0500
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 11:31:09 PST
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F8A9A5A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:31:09 -0800 (PST)
Received: from [84.39.87.63] (helo=optiplex980.fritz.box)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <vogelchr@vogel.cx>)
        id 1nSkwM-0004Pe-VT; Fri, 11 Mar 2022 20:28:43 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, vogelchr@vogel.cx
Subject: w1/ds2490: fix excessive logging
Date:   Fri, 11 Mar 2022 20:28:31 +0100
Message-Id: <20220311192833.1792-1-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues related to logging to the kernel-log are within w1/ds2490.

First, probably when automatically converting some logging to pr_info
it was overlooked that a lot of newlines are inserted.

Second by default ds2490 is excessively verbose on errors.

These two patches address the issues which were clogging up my harddisk
needlessly.


