Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28712C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 19:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiHATWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiHATWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:22:39 -0400
X-Greylist: delayed 8564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 12:22:36 PDT
Received: from host.olayscemailers.biz (olayscemailers.biz [92.63.169.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38B8A3892
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:22:36 -0700 (PDT)
Received: from olayscemailers.biz (unknown [113.30.188.128])
        by host.olayscemailers.biz (Postfix) with ESMTPA id 3B7B5103D7D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.olayscemailers.biz 3B7B5103D7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=olayscemailers.biz;
        s=default; t=1659370662;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=C0dQFJyq4eaDjWSx6oG0x1hQ6xLSHtngJpRNobZmrfdLqcig8lM4gibcMGpmTkCrt
         0bdItcRcjX4/kEOYU0dHoRwGDeITm+pL8KXFiKWHXVOsB+3TaXNFHFOdN+iBxFfhb5
         cTuz+D13hBy4iwZfttIVg1w7H5/665zBH+B4Rv2o=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.olayscemailers.biz 3B7B5103D7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=olayscemailers.biz;
        s=default; t=1659370662;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=C0dQFJyq4eaDjWSx6oG0x1hQ6xLSHtngJpRNobZmrfdLqcig8lM4gibcMGpmTkCrt
         0bdItcRcjX4/kEOYU0dHoRwGDeITm+pL8KXFiKWHXVOsB+3TaXNFHFOdN+iBxFfhb5
         cTuz+D13hBy4iwZfttIVg1w7H5/665zBH+B4Rv2o=
Reply-To: christospav209@secservermails.biz
From:   C Pavlides <christospav209@olayscemailers.biz>
To:     linux-kernel@vger.kernel.org
Subject: Collaboration
Date:   01 Aug 2022 19:17:42 +0300
Message-ID: <20220801191741.4BB93FA86499750B@olayscemailers.biz>
Mime-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

