Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B4ECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 23:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiH2Xsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiH2Xrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61086A722A;
        Mon, 29 Aug 2022 16:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EA561414;
        Mon, 29 Aug 2022 23:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467A3C433C1;
        Mon, 29 Aug 2022 23:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816807;
        bh=QYMLga9CqiAFWS9re24LJM8iwKIx2i4jrQzFcMgOlfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5F7lfo3mRqFU4of21qbfrfstESkCPU9JxV+BTnJ3NnJZjraNPrnjjvqPbX24hOnZ
         3a0BIKytZzG1Z3eqZFGaV+ba54R4q9l2zFHPdGqjeTz5q09fGng+F5xQpyK6GU95Qx
         7S/V7/4bnH8i3kk5EsmdqIPBEd1hLWUyaQf1npRSooR3rfIky+L9YMXbgSd4NdFyW/
         SxEii5+9TvyPJgIupi4PVTGM2jmIMEFo8S2pmcHRkfUIqHUaTWZglJlNLPvkN4xzYI
         0YVvtJmaXGZfvqyqriyQGk0QWH9ZnQEAYaIJP3/8MsPpJFI0Vs+UjcWFO6sPqKKPVh
         0VI7ALuVA7tZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     steev@kali.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: thinkpad-x13s: Fix firmware location
Date:   Mon, 29 Aug 2022 18:46:10 -0500
Message-Id: <166181675971.322065.15985449789465456864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817231236.3971-1-steev@kali.org>
References: <20220817231236.3971-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 18:12:36 -0500, Steev Klimaszewski wrote:
> The firmware for the Lenovo Thinkpad X13s has been submitted, accepted
> and merged upstream, so update to the correct path.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: thinkpad-x13s: Fix firmware location
      commit: b6a6535b339776d32fa515a18a93b1b317e9b063

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
