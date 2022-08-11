Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1AC19F2D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 08:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiHKIms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiHKImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:42:43 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDB68E0D1;
        Thu, 11 Aug 2022 01:42:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 210011E80D76;
        Thu, 11 Aug 2022 16:40:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mHlKViFkx0z1; Thu, 11 Aug 2022 16:40:37 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 69C801E80CE3;
        Thu, 11 Aug 2022 16:40:37 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        zhoujie@nfschina.com
Subject: Re: [PATCH] usb/serial:Modify the return value to void
Date:   Thu, 11 Aug 2022 16:42:36 +0800
Message-Id: <20220811084237.6651-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <YvS8AK9apa7tnYOz@kroah.com>
References: <YvS8AK9apa7tnYOz@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v2:
  Modifying function return value type does not work


