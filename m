Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E9FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 04:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiDFEh0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348237AbiDEVJd (ORCPT
        <rfc822;linux-kernel+subscribe@vger.kernel.org>);
        Tue, 5 Apr 2022 17:09:33 -0400
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 13:32:37 PDT
Received: from mail.wantyapps.xyz (unknown [66.135.5.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1BE8876
        for <linux-kernel+subscribe@vger.kernel.org>; Tue,  5 Apr 2022 13:32:37 -0700 (PDT)
Received: from wantyapps.localdomain (bzq-109-64-27-34.red.bezeqint.net [109.64.27.34])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id D796E839DB
        for <linux-kernel+subscribe@vger.kernel.org>; Tue,  5 Apr 2022 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1649190387;
        bh=2NGUGoBeJPZ/A1WnRklwB6yPj5s9Zuoi/XaFUYBDfmQ=;
        h=Date:From:To:Subject:From;
        b=gnpuG2P1GUHFJYgr4q5A9u+GNCfswE0LUb9kn+lknq5UGqOQpqpeX8q/IqvXGt0DG
         HpdbLufp9YRlGZjaDOnmovoRuty08RTL9WFwrF6m90JCep0XxQwEKnfcBWFlI8Gn+c
         Rc7gIbFhHtLjTsvdk9ZMKRIz3NTr29w9HjlV8Yd44j1sjnx1FDUQkVZn0yxRoK1Py9
         MOCkbtUTwqihsaxwPaZyI5s6VO4e/wArWHRIApKfpOKxxbICdtpualBnwqKZOqAYoh
         Tiz6lkYjlXciqh2/qtckDBy4/CN5pM2tNuAmqpTvL4z8tt2/5lRqAkA6HIv8IK+zsy
         sspyiBHBcithw==
Date:   Tue, 5 Apr 2022 23:26:21 +0300
From:   Uri Arev <me@wantyapps.xyz>
To:     linux-kernel+subscribe@vger.kernel.org
Subject: Subscription
Message-ID: <20220405202621.bz5fktmaxnlvehuz@wantyapps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this the way to subscribe to this mailing list?
