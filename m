Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA1CCA47E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 07:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbiFJHHv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiFJHHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:07:45 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 00:07:43 PDT
Received: from mx1.uni-regensburg.de (mx1.uni-regensburg.de [194.94.157.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DF2666
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:07:43 -0700 (PDT)
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 1E0EB600005A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:58:38 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id 04F706000051
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:58:38 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 10 Jun 2022 08:58:38 +0200
Message-Id: <62A2EB9C020000A10004ACB6@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.0 
Date:   Fri, 10 Jun 2022 08:58:36 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-kernel@vger.kernel.org>
Subject: Q: (rt)netlink documentation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working with an older kernel (SLES12 SP5, 4.12.14), trying to implement a module to access rtnetlink data, specifically that returned for RTM_GETLINK.
However I have the problem that the documentation on the packet structure is very poor, if not to say absent. So I fail to parse the response correctly.
Furthermore I realized (when trying to contact the maintainer), that "netlink" is not present in the MAINTAINERS file.

To be honest, the only working example I have is derived from some C code someone had published.
From the manual pages or header files (even from the kernel sources, or the Documentation directory) it's absolutely non-obvious how the data is structured and how to use those many macros defined.

NLMSG_ALIGN
RTA_ALIGN
RTA_OK
RTA_NEXT
RTA_LENGTH
RTA_SPACE
RTA_DATA
RTA_PAYLOAD
RTM_RTA
RTM_PAYLOAD
TCA_RTA
TCA_PAYLOAD
TA_RTA
TA_PAYLOAD
NFDN_RTMSG
NLMSG_LENGTH
NLMSG_SPACE
NLMSG_DATA
NLMSG_NEXT
NLMSG_OK
NLMSG_PAYLOAD
IFA_RTA
IFA_PAYLOAD
NFM_PAYLOAD
IFLA_RTA
IFLA_PAYLOAD
(This list is most likely not complete)

Regards,
Ulrich Windl
P.S.: Keep me on CC:, I'm not subscribed to LKML


