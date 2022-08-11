Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8DC19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 09:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiHKJFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiHKJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:05:08 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C39020BE7;
        Thu, 11 Aug 2022 02:05:06 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 74C4B1E80D32;
        Thu, 11 Aug 2022 17:03:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I1Wo2GY-nHMM; Thu, 11 Aug 2022 17:03:00 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C6A071E80CE3;
        Thu, 11 Aug 2022 17:03:00 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        zhoujie@nfschina.com
Subject: Re: [PATCH v2] usb/serial:Repair function return value
Date:   Thu, 11 Aug 2022 17:05:00 +0800
Message-Id: <20220811090501.6999-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <YvTDCpjrqxxK46Us@kroah.com>
References: <YvTDCpjrqxxK46Us@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The return value processing has been done in the write_mos_reg() function, no additional operations are required here, just return the result directly.
Also the indentation of the second line is now incorrect? What's wrong?

