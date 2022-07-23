Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C9C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 13:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGWNUa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:20:26 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45B7662
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658582410; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=GKrF4lVF8/lGlNX8+pbwvgmwXouFLLFgfjH7SEuJrsYid5O8CuThyIa6ouhzuGLice7iofDUrbOgLqdbVpU4NcnMWfR0+/imFT+A5Kskx6WIjOxPlmdbhQx3fol+wa4/is4lMJC+2NO10U2/kZpLzbNPRhyZjEVc4mctvoi7LHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658582410; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=e078esKtfkKf8uBCEFGUMF94RkrFcBEGTMP9CV9qNAM=; 
        b=GOtU7uQbXCYyCmhPHUTu/0Y7KDRBzOt06HtqIFbgfhBKrJTDuPLHvODGFVTsHQfMNUEuiP/NCgh4raiCzr1PRM2XkFQyxaxvJ0QwyALHbOlVep0bkG9weXzTt4BIp6Pdlgl55MTSE2jHey/MgFYbiQbztF2zBaIq1B8JLX15s/E=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658582410;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=e078esKtfkKf8uBCEFGUMF94RkrFcBEGTMP9CV9qNAM=;
        b=rc9gEVdIN4EIlZaIpwWogQfKTZsaXKCVuSFWxdhizlZB/upcvJf86ma6/qbDVTUI
        U8dhnAxKZMUBF19zlgub5ljuQm2Gv+V58oKHHsotK8AYGBwqgecSUfu+OIj/4cAG4se
        CfbufaVUYx9BzObBm80zPoeqqCpylc3CmnA+yJe4=
Received: from localhost.localdomain (43.250.158.127 [43.250.158.127]) by mx.zoho.in
        with SMTPS id 1658582409930951.2066169296836; Sat, 23 Jul 2022 18:50:09 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Cc:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <20220723132000.195982-1-code@siddh.me>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
Date:   Sat, 23 Jul 2022 18:50:00 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <000000000000aa07b205daba6d49@google.com>
References: <000000000000aa07b205daba6d49@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git@github.com:siddhpant/linux.git post_one_notification

