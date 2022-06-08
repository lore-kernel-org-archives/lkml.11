Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C092C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 00:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiFIACw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 20:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFIACr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:02:47 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 17:02:46 PDT
Received: from smtpq4.tb.ukmail.iss.as9143.net (smtpq4.tb.ukmail.iss.as9143.net [212.54.57.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E55FA1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:02:46 -0700 (PDT)
Received: from [212.54.57.97] (helo=smtpq2.tb.ukmail.iss.as9143.net)
        by smtpq4.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1nz5W1-00060F-If
        for linux-kernel@vger.kernel.org; Thu, 09 Jun 2022 01:55:09 +0200
Received: from [212.54.57.112] (helo=csmtp8.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1nz5Vy-0006Td-OM
        for linux-kernel@vger.kernel.org; Thu, 09 Jun 2022 01:55:06 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id z5VynnufyPoCmz5VynreOj; Thu, 09 Jun 2022 01:55:06 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=XaCaca15 c=1 sm=1 tr=0 ts=62a136da cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VnIsWBbqvtxzZ5ZNrjEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1654732506;
        bh=z/5XlDf7YQFWbf511OXQnI3Q0DQyTbFv2L+PDaN1D68=;
        h=Date:From:To:Subject;
        b=Ebk3rSzCTrWKNTJfx86RPnoaz5mEXnTqIzQzQiQO/yadG+nptTPVX1TCI3lymLyQj
         r93aiPzh2KymCEm+VtT8pHpw+HsnV/0xEdTR7o7p9G7+Mzgk4kCcMSwfSeYOdhPmhR
         DgLW32VBkSRR+yMqJQf2H/bbrUNzSITEwEN/AHMRG/WonhnqfZfRWIUIQUgQj417cj
         8hFCIN+FjQGmwL113Qu8OTvXukKTktAhVRXX3MsGNJsfmcz/0O2YCqmrUHv1Uv2Ujw
         ZT/p7YBDB5MWZn4QE+pqsyjrBAyWs8fbQ9j5l2sLs/19dGPDfHRx2T9bFbNWHTyL/z
         DpZDnWgMG8a7w==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 496178DBA9; Thu,  9 Jun 2022 00:55:06 +0100 (BST)
Date:   Thu, 9 Jun 2022 00:55:06 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     linux-kernel@vger.kernel.org
Subject: regression, 5.19.0-rc1 not powering off when hibernated
Message-ID: <YqE22nS9k2+AldI6@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.3 (2022-04-12)
X-CMAE-Envelope: MS4xfCeal9E2H8hpf7io+KyRzsi4urjh3e7VBECxpvhNP5Erexzk4DPtgLSjIWdlYXiDznbmufNJtsTNN9RoeXoZZXnZrEh5L6GUhPbAjdnD56wPhnhXCYzR
 nRUeNtm3zANd7Qf/KM3FTclvrA2qdYxZNexzwe2ByjpUyfXjoGNG34WuZnUSMLjHGsd+vHeEXO2synb1wXjZf8So017iYOq1sU4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
blanks, disk activity for the write to swap, screen briefly has a
trashed display, machine powers off.  When powering up from
hibernation, after the saved files are loaded X starts with a
briefly trashed display before my desktop reappears.

But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
and briefly when restoring (no complaint about that), but when
hibernating it no longer powers off and I have to hold the on/off
switch to power off.

Is this a known problem ?

ĸen
-- 
      Remembering The People's Republic of Treacle Mine Road.
        Truth!  Justice!  Freedom!  Reasonably priced Love!
                 And a Hard-boiled Egg!
