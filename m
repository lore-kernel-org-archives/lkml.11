Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72FDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 21:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiGUVRh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiGUVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:17:36 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4565D71
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:17:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdY2-001tWL-2b;
        Thu, 21 Jul 2022 22:17:30 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk
Subject: some sparse fixes
Date:   Thu, 21 Jul 2022 22:17:26 +0100
Message-Id: <20220721211729.451731-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some small fixes for sparse warnings.


