Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53645C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiBUTRV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:17:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiBUTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:17:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274CE24;
        Mon, 21 Feb 2022 11:16:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD8F5B8110B;
        Mon, 21 Feb 2022 19:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C488FC340E9;
        Mon, 21 Feb 2022 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471008;
        bh=PZtyPHG1xoMkx9cAbmffihZW+lwWdC2GGUxTck+TTi0=;
        h=From:To:Cc:Subject:Date:From;
        b=KpZUqB3fkJ5AqRokRq/L4852QN6BYgD1kODUJnr5JOCJUwJHMMEbn3FW/5US8aJGi
         DNVpKS49h+f5HpHGOqgcSxKNfGLDgCwh1nTo9BaoEWWKNjvCkP+jDZFMY2a5MbENIj
         WY9olmeAzYJwf+cXwvfoPadGoHKOcGd2lGdJzP6oKNauNrub+Il/6qDJXWDT2Gy/N2
         zaBduAgqlVqbWzlA8xlfOuJ/0BuE6RsFn5HC51Xd1Ot3feELetddvDEtMaXe0aG+5s
         fB2syhJnATR30N+Up15WHSgEkW0equZ9kfNhdmgvZPUZwaEBqqoSlBQWJIUixHn5fp
         fDsOpLUILvmDg==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: linux-next: manual merge of the usb tree with the qcom tree
Date:   Mon, 21 Feb 2022 19:16:41 +0000
Message-Id: <20220221191641.1661387-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/boot/dts/qcom/ipq6018.dtsi

between commit:

  d1c10ab1494f0 ("arm64: dts: qcom: ipq6018: fix usb reference period")

from the qcom tree and commit:

  5726079cd4860 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e7efa97724bd,a614b9f73e2cd..0000000000000
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi

(deleted the property updated by the qcom patch)
